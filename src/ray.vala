public struct ray {
    public point3 orig;
    public vec3 dir;

    public ray (point3 origin, vec3 direction) {
    	orig = origin;
    	dir = direction;
    }

    public point3 origin { get { return orig; } }
    public vec3 direction { get { return dir; } }

    public point3 at (double t) {
    	return (point3) orig.add (dir.scale (t));
    }
}
