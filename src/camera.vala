double degrees_to_radians (double degs) {
    return degs * Math.PI / 180;
}

class Camera {
    point3 origin;
    vec3 horizontal;
    vec3 vertical;
    point3 lower_left_corner;

    public Camera (point3 lookfrom, point3 lookat, vec3 vup, double vfov, double aspect_ratio) {
        var theta = degrees_to_radians (vfov);
        var h = Math.tan (theta / 2);
        var viewport_height = 2 * h;
        var viewport_width = aspect_ratio * viewport_height;

        var w = lookfrom.substract (lookat).unit_vector ();
        var u = vup.cross (w).unit_vector ();
        var v = w.cross (u);

        origin = lookfrom;
        horizontal = u.scale (viewport_width);
        vertical = v.scale (viewport_height);
        lower_left_corner = origin.substract (horizontal.divide (2))
                                  .substract (vertical.divide (2))
                                  .substract (w);
    }

    public ray get_ray (double s, double t) {
        return ray (origin, lower_left_corner.add (horizontal.scale (s)).add (vertical.scale (t)).substract (origin));
    }
}
