library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 2.1
--entity zusatzaufgaben is
--	port (
--		x,y,z : in unsigned (11 downto 0);
--		result : out unsigned (13 downto 0)
--	);
--end entity zusatzaufgaben;
--
--architecture adder of zusatzaufgaben is
--	
--begin
--	result <= resize(x,result'length) + resize(y,result'length) + resize(z,result'length); 
--end architecture ;

-- 2.2
--Entwickeln Sie ein VHDL Modell, das drei 12-bit unsigned-Werte zu einem 12-bit-unsigned Re-
--sultat addiert mit overflow-Erkennung
--entity zusatzaufgaben is
--	port (
--		x,y,z : in unsigned (11 downto 0);
--		result : out unsigned (11 downto 0);
--		ov : out std_ulogic
--	);
--end entity zusatzaufgaben;
--
--architecture adder of zusatzaufgaben is
--	signal tmp : unsigned (13 downto 0);
--begin
--	tmp <= resize(x,tmp'length) + resize(y,tmp'length) + resize(z,tmp'length); 
--	result <= tmp(11 downto 0);
--	ov <= '1' when tmp(13) = '1' or tmp(12) = '1' else '0';
--end architecture ;

-- 2.3
--Führen Sie mit beiden unsigned-Zahlen ein logisches Links-Schieben um 4 Positionen aus, um
--ein 12-bit-Resultat zu erhalten. Gibt es einen Overflow?
--Zahl 1: 000111000110
--Zahl 2: 000010110100
--entity zusatzaufgaben is
--	port (
--		out1, out2 : out unsigned (11 downto 0)
--	);
--end entity zusatzaufgaben;
--
--architecture adder of zusatzaufgaben is
--	constant c1 : unsigned(11 downto 0) := "000111000110";
--	constant c2 : unsigned(11 downto 0) := "000010110100";
--begin
--	out1 <= shift_left(c1, 4);
--	out2 <= shift_left(c2, 4);
--end architecture ;

--Übung 2.4
--Führen Sie mit beiden unsigned-Zahlen ein logisches Rechts-Schieben um 4 Positionen aus,
--um ein 12-bit-Resultat zu erhalten. Repräsentiert das Resultat in beiden Fällen genau eine Divi-
--son durch 16?
--Zahl 1: 100101010000
--Zahl 2: 000101001000
--entity zusatzaufgaben is
--	port (
--		out1, out2 : out unsigned (11 downto 0)
--	);
--end entity zusatzaufgaben;
--
--architecture adder of zusatzaufgaben is
--	constant c1 : unsigned(11 downto 0) := "100101010000";
--	constant c2 : unsigned(11 downto 0) := "000101001000";
--begin
--	out1 <= shift_right(c1, 4);
--	out2 <= shift_right(c2, 4);
--end architecture ;


--Übung 2.5
--Entwickeln Sie ein VHDL Modell eines Converters, der einen 4-bit-unsigned Wert in einen 4-bit-
--Gray-codierten Wert wandelt
entity zusatzaufgaben is
	port (
		in_val : in unsigned (3 downto 0);
		out_val : out std_ulogic_vector (3 downto 0)
	);
end entity zusatzaufgaben;

architecture adder of zusatzaufgaben is
begin
	out_val <= "0000" when in_val = 0 else
			   "0001" when in_val = 1 else
			   "0011" when in_val = 2 else
			   "0010" when in_val = 3 else
			   "0110" when in_val = 4 else
			   "0111" when in_val = 5 else
			   "0101" when in_val = 6 else
			   "0100" when in_val = 7 else
			   "1100" when in_val = 8 else
			   "1101" when in_val = 9 else
			   "1111" when in_val = 10 else
			   "1110" when in_val = 11 else
			   "1010" when in_val = 12 else
			   "1011" when in_val = 13 else
			   "1001" when in_val = 14 else
			   "1000";
end architecture ;












