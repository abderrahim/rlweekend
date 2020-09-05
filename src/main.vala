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

color ray_color(ray r, Hittable world) {
    HitRecord rec = {};
    if (world.hit (r, 0, double.INFINITY, ref rec)) {
        return rec.normal.add (color (1, 1, 1)).scale (0.5);
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

    // World
    var world = new HittableList ();
    world.add (new Sphere (point3 (0, 0, -1), 0.5));
    world.add (new Sphere (point3 (0, -100.5, -1), 100));

    // Camera

    var viewport_height = 2.0;
    var viewport_width = aspect_ratio * viewport_height;
    var focal_length = 1.0;

    var origin = point3 (0, 0, 0);
    var horizontal = vec3 (viewport_width, 0, 0);
    var vertical = vec3 (0, viewport_height, 0);
    var lower_left_corner = vec3 (-viewport_width/2, -viewport_height/2, - focal_length);

    // Render

    print ("P3\n");
    print (@"$image_width $image_height\n");
    print ("255\n");

	for (int j = image_height - 1; j >= 0; j--) {
	    printerr (@"\rScanlines remaining: $j ");
	    for (int i = 0; i < image_width; i++) {
	        var u = (double) i / (image_width - 1);
	        var v = (double) j / (image_height - 1);
	        // lower_left_corner + u*horizontal.scale + v*vertical - origin
	        var r = ray (origin, lower_left_corner.add (horizontal.scale (u)).add (vertical.scale (v)).add (origin.negate ()));
	        var pixel_color = ray_color (r, world);
	        print(@"$pixel_color\n");
	    }
	}

	printerr ("\nDone.\n");
	return 0;
}
