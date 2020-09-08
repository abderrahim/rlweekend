public abstract class Material {
    public abstract bool scatter (ray r_in, HitRecord rec, out color attenuation, out ray scattered);
}

public vec3 random_unit_vector () {
    var a = Random.double_range (0, 2*Math.PI);
    var z = Random.double_range (-1, 1);
    var r = Math.sqrt (1 - z*z);
    return vec3 (r * Math.cos (a), r * Math.sin (a), z);
}

public class Lambertian : Material {
    color albedo;

    public Lambertian (color a) {
        albedo = a;
    }

    public override bool scatter (ray r_in, HitRecord rec, out color attenuation, out ray scattered) {
        var scatter_direction = rec.normal.add (random_unit_vector ());
        scattered = ray (rec.p, scatter_direction);
        attenuation = albedo;
        return true;
    }
}

public vec3 random_in_unit_sphere () {
    while (true) {
        var p = vec3.random_range (-1, 1);
        if (p.length_squared () >= 1)
            continue;

        return p;
    }
}

public class LazyHackDiffuse : Material {
    color albedo;

    public LazyHackDiffuse (color a) {
        albedo = a;
    }

    public override bool scatter (ray r_in, HitRecord rec, out color attenuation, out ray scattered) {
        var scatter_direction = rec.normal.add (random_in_unit_sphere ());
        scattered = ray (rec.p, scatter_direction);
        attenuation = albedo;
        return true;
    }
}

public vec3 random_in_hemisphere (vec3 normal) {
    var in_unit_sphere = random_in_unit_sphere ();
    if (in_unit_sphere.dot (normal) > 0) // In the same hemisphere as the normal
        return in_unit_sphere;
    else
        return in_unit_sphere.negate ();
}

public class OldDiffuse : Material {
    color albedo;

    public OldDiffuse (color a) {
        albedo = a;
    }

    public override bool scatter (ray r_in, HitRecord rec, out color attenuation, out ray scattered) {
        var scatter_direction = random_in_hemisphere (rec.normal);
        scattered = ray (rec.p, scatter_direction);
        attenuation = albedo;
        return true;
    }
}


vec3 reflect (vec3 v, vec3 n) {
    return v.substract (n.scale (2 * v.dot (n)));
}

public class Metal : Material {
    color albedo;

    public Metal (color a) {
        albedo = a;
    }

    public override bool scatter (ray r_in, HitRecord rec, out color attenuation, out ray scattered) {
        var reflected = reflect (r_in.direction.unit_vector (), rec.normal);
        scattered = ray (rec.p, reflected);
        attenuation = albedo;
        return (scattered.direction.dot (rec.normal) > 0);
    }
}
