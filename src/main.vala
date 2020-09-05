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

int main (string[] args)
{

    // Image
    int image_width = 256;
    int image_height = 256;

    // Render

    print ("P3\n");
    print (@"$image_width $image_height\n");
    print ("255\n");

	for (int j = image_height - 1; j >= 0; j--) {
	    printerr (@"\rScanlines remaining: $j ");
	    for (int i = 0; i < image_width; i++) {
	        var pixel_color = color ((double) i / (image_width - 1),
	                                 (double) j / (image_height - 1),
	                                 0.25);
	        print(@"$pixel_color\n");
	    }
	}

	printerr ("\nDone.\n");
	return 0;
}
