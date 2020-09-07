/* main.vala
 *
 * Copyright 2020 Abderrahim Kitouni
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public vec3 random_unit_vector () {
    var a = Random.double_range (0, 2*Math.PI);
    var z = Random.double_range (-1, 1);
    var r = Math.sqrt (1 - z*z);
    return vec3 (r * Math.cos (a), r * Math.sin (a), z);
}

color ray_color(ray r, Hittable world, int depth) {
    HitRecord rec = {};

    // If we exceeded the ray bounce limit, no more light is gathered
    if (depth <= 0)
        return color (0, 0, 0);

    if (world.hit (r, 0.001, double.INFINITY, ref rec)) {
        point3 target = rec.p.add (rec.normal).add (random_unit_vector ());
        return ray_color (ray (rec.p, target.substract (rec.p)), world, depth - 1).scale (0.5);
    }

    var unit_direction = r.direction.unit_vector();
    var t = 0.5 * (unit_direction.y + 1.0);
    return color (1, 1, 1).scale (1.0-t).add (color (0.5, 0.7, 1.0).scale (t));
}

int main (string[] args)
{

    // Image
    var aspect_ratio = 16.0 / 9.0;
    int image_width = 400;
    int image_height = (int) (image_width / aspect_ratio);
    int samples_per_pixel = 100;
    int max_depth = 50;

    // World
    var world = new HittableList ();
    world.add (new Sphere (point3 (0, 0, -1), 0.5));
    world.add (new Sphere (point3 (0, -100.5, -1), 100));

    // Camera

    var cam = new Camera ();

    // Render

    print ("P3\n");
    print (@"$image_width $image_height\n");
    print ("255\n");

    for (int j = image_height - 1; j >= 0; j--) {
        printerr (@"\rScanlines remaining: $j ");
        for (int i = 0; i < image_width; i++) {
            color pixel_color = {};
            for (int s = 0; s < samples_per_pixel; s++) {
                var u = (i + Random.next_double ()) / (image_width - 1);
                var v = (j + Random.next_double ()) / (image_height - 1);
                var r = cam.get_ray (u, v);
                pixel_color = pixel_color.add (ray_color (r, world, max_depth));
            }
            pixel_color = pixel_color.divide (samples_per_pixel);

            // gamma-correct for gamma = 2
            pixel_color = color (Math.sqrt (pixel_color.x),
                                 Math.sqrt (pixel_color.y),
                                 Math.sqrt (pixel_color.z));

            print(@"$pixel_color\n");
        }
    }

    printerr ("\nDone.\n");
    return 0;
}
