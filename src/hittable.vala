public struct HitRecord {
    public point3 p;
    public vec3 normal;
    public Material mat;
    public double t;
    public bool front_face;

    public void set_face_normal (ray r, vec3 outward_normal) {
        front_face = r.direction.dot (outward_normal) < 0;
        normal = front_face ? outward_normal : outward_normal.negate ();
    }
}

public abstract class Hittable {
    public abstract bool hit (ray r, double t_min, double t_max, ref HitRecord rec);
}
