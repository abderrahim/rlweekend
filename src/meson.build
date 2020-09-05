raytracinginoneweekend_sources = [
  'main.vala',
]

raytracinginoneweekend_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

executable('raytracinginoneweekend', raytracinginoneweekend_sources,
  vala_args: '--target-glib=2.58',  dependencies: raytracinginoneweekend_deps,
  install: true,
)
