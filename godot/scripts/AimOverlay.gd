extends Node2D
class_name AimOverlay
## Dotted trajectory preview + ghost landing bubble. Ported from v1.
##
## Cannon owns this and updates `polyline` + `landing` whenever the player drags.
## Lives as a child of MatchScene root so local space == world space.

const DOT_SPACING_PX: float = 28.0
const DOT_BASE_RADIUS: float = 5.0
const DOT_TIP_RADIUS: float = 3.0
const GHOST_VISIBLE: float = Bubble.TARGET_VISIBLE_DIAMETER * 0.95
const PATH_RADIUS: float = 28.0
const PATH_FILL_ALPHA: float = 0.11
const FADE_NEAR_ALPHA: float = 0.85
const FADE_FAR_ALPHA: float = 0.15
const ELBOW_RADIUS: float = 4.0
const DOT_OUTLINE: Color = Color(0, 0, 0, 0.55)

var polyline: PackedVector2Array = PackedVector2Array()
var landing: Vector2 = Vector2.ZERO
var has_landing: bool = false
var bubble_color: String = "RED"

func set_polyline(pts: PackedVector2Array, color: String, land_pos: Variant = null) -> void:
	polyline = pts
	bubble_color = color
	has_landing = land_pos is Vector2
	if has_landing:
		landing = land_pos
	queue_redraw()

func clear() -> void:
	polyline = PackedVector2Array()
	has_landing = false
	queue_redraw()

func _draw() -> void:
	if polyline.size() < 2:
		return
	var col: Color = Bubble.COLORS.get(bubble_color, Color.WHITE)
	# Total length drives the per-dot fade.
	var total_len: float = 0.0
	for i in range(polyline.size() - 1):
		total_len += polyline[i].distance_to(polyline[i + 1])
	if total_len <= 0.0:
		return
	# Faint thick ray = the bubble's clearance envelope. Gaps that look open to
	# the centerline but not to the full ball read as blocked.
	for seg in range(polyline.size() - 1):
		draw_line(polyline[seg], polyline[seg + 1],
			Color(col.r, col.g, col.b, PATH_FILL_ALPHA), PATH_RADIUS * 2.0, true)
	# Walk the polyline at fixed spacing; emit a fading dot at each step.
	var dist_along: float = DOT_SPACING_PX * 0.5
	for seg in range(polyline.size() - 1):
		var a: Vector2 = polyline[seg]
		var b: Vector2 = polyline[seg + 1]
		var seg_len: float = a.distance_to(b)
		if seg_len <= 0.001:
			continue
		var seg_start_dist: float = _dist_to_seg_start(seg)
		while dist_along < seg_start_dist + seg_len:
			var t: float = (dist_along - seg_start_dist) / seg_len
			var p: Vector2 = a.lerp(b, t)
			var u: float = dist_along / total_len
			var alpha: float = lerp(FADE_NEAR_ALPHA, FADE_FAR_ALPHA, u)
			var r: float = lerp(DOT_BASE_RADIUS, DOT_TIP_RADIUS, u)
			draw_circle(p, r + 1.0, Color(DOT_OUTLINE.r, DOT_OUTLINE.g, DOT_OUTLINE.b, alpha * 0.7))
			draw_circle(p, r, Color(col.r, col.g, col.b, alpha))
			dist_along += DOT_SPACING_PX
		# Bend marker at each ricochet so the bounce reads.
		if seg < polyline.size() - 2:
			draw_circle(polyline[seg + 1], ELBOW_RADIUS, Color(col.r, col.g, col.b, 0.55))
	# Ghost bubble at the predicted landing point.
	var land_pos: Vector2 = landing if has_landing else polyline[polyline.size() - 1]
	_draw_ghost(land_pos, col)

func _dist_to_seg_start(seg_idx: int) -> float:
	var d: float = 0.0
	for i in range(seg_idx):
		d += polyline[i].distance_to(polyline[i + 1])
	return d

func _draw_ghost(world_pos: Vector2, col: Color) -> void:
	var tex: Texture2D = Bubble._get_bubble_tex(bubble_color)
	if tex != null:
		var cal: Dictionary = Bubble.get_draw_rect(tex, GHOST_VISIBLE)
		var rect := Rect2(Vector2(cal["pos"]) + world_pos, Vector2(cal["size"]))
		draw_texture_rect(tex, rect, false, Color(1, 1, 1, 0.45))
		return
	# Greybox fallback — colored circle ring.
	var ghost_r: float = Bubble.RADIUS
	draw_arc(world_pos, ghost_r, 0.0, TAU, 24, Color(col.r, col.g, col.b, 0.55), 3.0, true)
	draw_circle(world_pos, ghost_r - 2.0, Color(col.r, col.g, col.b, 0.18))
