raytracinginoneweekend_sources = [
  'main.vala',
  'vec3.vala',
  'ray.vala',
  'hittable.vala',
  'sphere.vala',
  'hittable_list.vala',
  'camera.vala',
]

cc = meson.get_compiler('c')

raytracinginoneweekend_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  cc.find_library('m', required: false),
]

executable('raytracinginoneweekend', raytracinginoneweekend_sources,
  vala_args: '--target-glib=2.58',  dependencies: raytracinginoneweekend_deps,
  install: true,
)
