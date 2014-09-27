{application, cells_app,
 [{description, "Cubic cell simulator"},
  {vsn, "1"},
  {modules, [cells_app, cells_sup, cells]},
  {registered, [cells]},
  {applications, [kernel, stdlib, sasl]},
  {mod, {cells, []}},
  {env, []}
 ]}.
