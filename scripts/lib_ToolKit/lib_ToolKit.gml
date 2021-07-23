function Array() {
    var _arr = array_create(argument_count);
    for (var i = 0; i < argument_count; i++) _arr[i] = argument[i];
    //
    var this = method({ arr: _arr }, function() {
        if (argument_count > 1) {
            arr[@argument[0]] = argument[1];
        } else return arr[argument[0]];
    });
    with (this) {
        arr = _arr;
        function resize(newsize) {
            array_resize(arr, newsize);
        }
        function get(index){
            return arr[index];
        }
        function toString() {
            return string(arr);
        }
        function push(){
            for(var i = 0; i < argument_count; i++){
                array_push(arr,argument[i]);
            }
        }
        function pop(){
            array_pop(arr);
        }
		function remove(index){
			array_delete(arr,index,1);
		}
        function size(){
            return array_length(arr);
        }
		function sort(func){
			array_sort(arr, func);
		}
    }
    return this;
}
/// @hint Array(...values)
/// @hint Array:(index, ?newValue)
/// @hint Array:resize(newsize)
/// @hint Array:toString()->string
/// @hint Array:push(...values)
/// @hint Array:pop()
/// @hint Array:size()->number


function world_to_GUI(vec3/*: Vector3*/) {
	matrix_stack_clear();
	matrix_stack_push(camera_get_proj_mat(view_camera[0]));
	matrix_stack_push(camera_get_view_mat(view_camera[0]));
	vec3 = matrix_transform_vertex(matrix_stack_top(), vec3.x, vec3.y, vec3.z);

	var vec2 = {x: 0,y: 0,z: 0};
	vec2.x = vec3[0]/vec3[2];
	vec2.y = vec3[1]/vec3[2];
	vec2.x = view_xport[0] + view_wport[0] * (1 + vec2.x) * 0.5;
	vec2.y = view_yport[0] + view_hport[0] * (1 - vec2.y) * 0.5;

	return vec2;


}


function copy_struct(old_struct,new_struct){
	var list = variable_struct_get_names(old_struct);
	for(var i = 0; i < array_length(list); i++){
		new_struct[$ list[i]] = old_struct[$ list[i]];
	}
}