{application, cells_app,
 [{description, "Cubic cell simulator"},
  {vsn, "1"},
  {modules, [cells_app,
             cells_sup,
             cells_cell,
             cells_megablock_sup,
             cells_kiloblock_sup,
             cells_mob]},
  {registered, [cells]},
  {applications, [kernel, stdlib, sasl]},
  {mod, {cells_app, []}},
  {env, []}
 ]}.
