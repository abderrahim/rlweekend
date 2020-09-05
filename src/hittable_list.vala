public class HittableList : Hittable {
    GenericArray<Hittable> objects = new GenericArray<Hittable> ();
    public HittableList () {}

    public void clear () {
        objects = new GenericArray<Hittable> ();
    }

    public void add (Hittable obj) {
        objects.add (obj);
    }

    public override bool hit (ray r, double t_min, double t_max, ref HitRecord rec) {
        HitRecord temp_rec = {};
        var hit_anything = false;
        var closest_so_far = t_max;

        for (int i = 0; i < objects.length; i++) {
            var object = objects[i];
            if (object.hit (r, t_min, closest_so_far, ref temp_rec)) {
                hit_anything = true;
                closest_so_far = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }
}
