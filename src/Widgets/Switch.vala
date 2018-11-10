/*
 * Copyright (c) 2018 Daniel Pinto (https://github.com/danielpinto8zz6/budgie-network-applet)
 * Copyright (c) 2011-2018 elementary, Inc. (https://elementary.io)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */

public class Network.Widgets.Switch : Network.Widgets.Container {
    public new signal void switched ();

    public bool active { get; set; }
    public string caption { owned get; set; }
    public string icon_name { owned get; construct; }

    private Gtk.Label button_label;
    private Gtk.Image button_image;
    private Gtk.Switch button_switch;

    public Switch (string caption, string icon_name, bool active = false) {
        Object (caption: caption, icon_name: icon_name, active: active);
    }

    public Switch.with_mnemonic (string caption, string icon_name, bool active = false) {
        Object (caption: caption, icon_name: icon_name, active: active);
        button_label.set_text_with_mnemonic (caption);
        button_label.set_mnemonic_widget (this);
    }

    construct {
        button_switch = new Gtk.Switch ();
        button_switch.active = active;
        button_switch.halign = Gtk.Align.END;
        button_switch.margin_end = 6;
        button_switch.hexpand = true;
        button_switch.valign = Gtk.Align.CENTER;

        button_image = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.MENU);
        button_image.halign = Gtk.Align.CENTER;
        button_image.valign = Gtk.Align.CENTER;

        button_label = new Gtk.Label (null);
        button_label.halign = Gtk.Align.START;
        button_label.margin_start = 6;
        button_label.margin_end = 10;

        content_widget.attach (button_image, 0, 0, 1, 1);
        content_widget.attach (button_label, 1, 0, 1, 1);
        content_widget.attach (button_switch, 2, 0, 1, 1);

        clicked.connect (() => {
            toggle_switch ();
        });

        bind_property ("active", button_switch, "active", GLib.BindingFlags.SYNC_CREATE|GLib.BindingFlags.BIDIRECTIONAL);
        bind_property ("caption", button_label, "label", GLib.BindingFlags.SYNC_CREATE|GLib.BindingFlags.BIDIRECTIONAL);
        button_switch.notify["active"].connect (() => {
            switched ();
        });
    }

    public new Gtk.Label get_label () {
        return button_label;
    }

    public Gtk.Switch get_switch () {
        return button_switch;
    }

    public void toggle_switch () {
        button_switch.activate ();
    }
}