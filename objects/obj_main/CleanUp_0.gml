var line_count = 100;
show_debug_message(string_repeat("-", line_count));
show_debug_message("Start destroy assets\n");

show_debug_message("Deleting VertexBuffer's...");
for(var i = 0; i < global.BufferList.size(); i++){
    global.BufferList(i).destroy();
}
show_debug_message(string(global.BufferList.size()) + " destroyed VertexBuffer's");

show_debug_message("\nEnd destroy assets");
show_debug_message(string_repeat("-", line_count));