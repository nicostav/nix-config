# ============================================================
# modules/user/sublime.nix
# ============================================================
{ config, pkgs, ... }:

{
	home.file.".config/sublime-text/Packages/User/Preferences.sublime-settings".text = ''
	    {
	      "font_face": "FiraCode Nerd Fonts Mono",
	      "font_size": 13,
	      "translate_tabs_to_spaces": true,
	      "trim_trailing_white_space_on_save": true,
	      "ensure_newline_at_eof_on_save": true,
	      "word_wrap": false,
	      "highlight_line": true,
	      "show_encoding": true,
	      "show_line_endings": true,
	      "update_check": false,
	      "ignored_packages":
			[
				"Vintage",
			],
			"index_files": true,
			"color_scheme": "Packages/ayu/ayu-mirage.sublime-color-scheme",
			"theme": "ayu-mirage.sublime-theme",
			"scroll_past_end": false,
			"vintage_start_in_command_mode": true,
			"tab_size": 4,
			"translate_tabs_to_spaces": true,
			"use_tab_stops": true,
			"detect_indentation": false,
			"ui_native_titlebar": false,
	    }
	 '';

	 home.file.".config/sublime-text/Packages/User/Package Control.sublime-settings".text = ''
	    {
			"bootstrapped": true,
			"in_process_packages":
			[
			],
			"installed_packages":
			[
				"A File Icon",
				"AutoDocstring",
				"ayu",
				"Git",
				"Indent XML",
				"LSP",
				"LSP-json",
				"Package Control",
				"python-black",
				"SideBarEnhancements",
				"SublimeLinter-xmllint",
				"Nix",
			],
		}
	 '';
}
