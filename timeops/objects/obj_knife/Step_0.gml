/// @description

var inst = instance_place(x, y, obj_enemy);
if (inst != noone && !damaged)
{
	instance_destroy(inst);
	damaged = true;
}