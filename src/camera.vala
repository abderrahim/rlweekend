double degrees_to_radians (double degs) {
    return degs * Math.PI / 180;
}

class Camera {
    point3 origin;
    vec3 horizontal;
    vec3 vertical;
    point3 lower_left_corner;

    public Camera (double vfov, double aspect_ratio) {
        var theta = degrees_to_radians (vfov);
        var h = Math.tan (theta / 2);
        var viewport_height = 2 * h;
        var viewport_width = aspect_ratio * viewport_height;
        var focal_length = 1.0;

        origin = point3 (0, 0, 0);
        horizontal = vec3 (viewport_width, 0, 0);
        vertical = vec3 (0, viewport_height, 0);
        lower_left_corner = point3 (-viewport_width/2, -viewport_height/2, - focal_length);
    }

    public ray get_ray (double u, double v) {
        return ray (origin, lower_left_corner.add (horizontal.scale (u)).add (vertical.scale (v)).add (origin.negate ()));
    }
}
