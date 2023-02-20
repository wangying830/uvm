# DVE version E-2011.03-3
# Preferences written on Mon Jul 18 10:20:02 2011
gui_set_var -name {read_pref_file} -value {true}
gui_create_pref_key -category {Globals} -key {load_detail_for_funcov} -value_type {bool} -value {false}
gui_set_pref_value -category {Globals} -key {tooltip_max_height} -value {50}

gui_create_pref_category -category {dlg_settings}
gui_create_pref_key -category {dlg_settings} -key {tableWithImmediatePopup} -value_type {bool} -value {true}
gui_set_var -name {read_pref_file} -value {false}
