public class Sphere : Hittable {
    point3 center;
    double radius;

    public Sphere (point3 cen, double r) {
        center = cen;
        radius = r;
    }

    public override bool hit (ray r, double tmin, double tmax, ref HitRecord rec) {
        var oc = r.origin.substract (center);
        var a = r.direction.length_squared ();
        var half_b = oc.dot (r.direction);
        var c = oc.length_squared () - radius * radius;
        var discriminant = half_b * half_b - a * c;

        if (discriminant > 0) {
            var root = Math.sqrt (discriminant);

            var temp = (-half_b - root) / a;
            if (temp < tmax && temp > tmin) {
                rec.t = temp;
                rec.p = r.at (rec.t);
                var outward_normal = rec.p.substract (center).divide (radius);
                rec.set_face_normal (r, outward_normal);
                return true;
            }

            temp = (-half_b + root) / a;
            if (temp < tmax && temp > tmin) {
                rec.t = temp;
                rec.p = r.at (rec.t);
                var outward_normal = rec.p.substract (center).divide (radius);
                rec.set_face_normal (r, outward_normal);
                return true;
            }
        }

        return false;
    }
}
