public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.mashebang.uniqnote",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var textarea = new Gtk.TextView();
        var buffer = textarea.get_buffer();
        File file = File.new_for_path (".content.md");

        try {
            FileInputStream @is = file.read ();
            DataInputStream dis = new DataInputStream (@is);
            string line;
    
            while ((line = dis.read_line ()) != null) {
                Gtk.TextIter start;
                Gtk.TextIter end;
                buffer.get_bounds(out start, out end);
                buffer.set_text(buffer.get_text(start, end, true).concat("\n", line));
            }
        } catch (Error e) {
            print ("Error: %s\n", e.message);
        }

        

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "uniqnote"
        };

        main_window.add (textarea);
        main_window.show_all ();

        Gdk.Event.handler_set((data) => {
            print("event");
        });
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
