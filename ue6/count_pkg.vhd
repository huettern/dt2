package count_pkg is
	TYPE nat_ar IS ARRAY (0 TO 1) OF natural;
	constant c_start_values : nat_ar;
	constant c_end_values : nat_ar;
end package count_pkg;

package body count_pkg is
	constant c_start_values : nat_ar := (0, 0);
	constant c_end_values : nat_ar := (59, 59);
end package body count_pkg;
