public struct vec3 {
    public double e[3];

    public vec3 (double e0, double e1, double e2) {
        e = {e0, e1, e2};
    }

    public double x { get { return e[0]; } }
    public double y { get { return e[1]; } }
    public double z { get { return e[2]; } }

    public vec3 negate () { return vec3 (-e[0], -e[1], -e[2]); }
    public double get (int i) { return e[i]; }
    public void set (int i, double t) { e[i] = t; }

    public vec3 add (vec3 v) {
        return vec3 (e[0] + v.e[0], e[1] + v.e[1], e[2] + v.e[2]);
    }

    public vec3 scale (double t) {
        return vec3 (e[0]*t, e[1]*t, e[2]*t);
    }

    public vec3 divide (double t) { return scale(1/t); }

    public vec3 multiply (vec3 v) {
        return vec3 (e[0] + v.e[0], e[1] + v.e[1], e[2] + v.e[2]);
    }

    public double length { get { return Math.sqrt (length_squared); } }
    public double length_squared {
        get { return e[0] * e[0] + e[1] * e[1] + e[2] * e[2]; }
    }

    public string to_string () {
        return "%f %f %f".printf(e[0], e[1], e[2]);
    }

    public double dot (vec3 v) {
        return e[0] * v.e[0] + e[1] * v.e[1] + e[2] * v.e[2];
    }

    public vec3 cross (vec3 v) {
        return vec3 (e[1] * v.e[2] - e[2] * v.e[1],
                     e[2] * v.e[0] - e[0] * v.e[2],
                     e[0] * v.e[1] - e[1] * v.e[0]);
    }

    public vec3 unit_vector () {
        return divide (length);
    }
}

// Type aliases for vec3
public struct point3 : vec3 {
    public point3 (double x, double y, double z) { base (x, y, z); }
}
public struct color : vec3 {
    public color (double r, double g, double b) { base (r, g, b); }
    public new string to_string () {
        return "%d %d %d".printf((int) (255.999 * x), (int) (255.999 * y), (int) (255.999 * z));
    }
}
