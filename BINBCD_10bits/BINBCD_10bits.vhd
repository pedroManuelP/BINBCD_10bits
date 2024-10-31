--biblioteca
library ieee;
use ieee.std_logic_1164.all;

--entidade
entity BINBCD_10bits is
	port(
		SW: in std_logic_vector(9 downto 0);
		BCD: out std_logic_vector(12 downto 0)
	);
end BINBCD_10bits;

--arquitetura
architecture Hardware of BINBCD_10bits is
	component conversorModulo is
		port(
			a3, a2, a1, a0: in std_logic;
			s3, s2, s1, s0: out std_logic
		);
	end component;

	
	constant zero: std_logic:= '0';
	signal s1,s2,s3,s4: std_logic; -- conversor1
	signal s5,s6,s7,s8: std_logic; -- conversor2
	signal s9,s10,s11,s12: std_logic; -- conversor3
	signal e4,s13,s14,s15: std_logic; -- conversor4
	
	signal o1,o2,o3,o4: std_logic; -- conversor 5
	signal e0,o5,o6,o7: std_logic; -- conversor 6
	signal o8,o9,o10,o11: std_logic; -- conversor 7
	signal e1,o12,o13,o14: std_logic; -- conversor 8
	
	signal o15,o16,o17,o18: std_logic; -- conversor9
	signal e2,o19,o20,o21: std_logic; -- conversor10
	signal o22,o23,o24,o25: std_logic; -- conversor11
begin
	conversor1: conversorModulo port map(zero,zero,SW(9),SW(8), s1, s2, s3, s4);
	conversor2: conversorModulo port map(s2,s3,s4,SW(7),s5,s6,s7,s8);
	conversor3: conversorModulo port map(s6,s7,s8,SW(6),s9,s10,s11,s12);
	conversor4: conversorModulo port map(zero,s1,s5,s9,e4,s13,s14,s15); ----------------bcd12
	
	conversor5: conversorModulo port map(s10,s11,s12,SW(5),o1,o2,o3,o4);
	conversor6: conversorModulo port map(s13,s14,s15,o1,e0,o5,o6,o7);----------------bcd11
	conversor7: conversorModulo port map(o2,o3,o4,SW(4),o8,o9,o10,o11);
	conversor8: conversorModulo port map(o5,o6,o7,o8,e1,o12,o13,o14);------------------bcd10
	
	conversor9: conversorModulo port map(o9,o10,o11,SW(3),o15,o16,o17,o18);
	conversor10: conversorModulo port map(o12,o13,o14,o15,e2,o19,o20,o21);-----------------bcd9
	conversor11: conversorModulo port map(o16,o17,o18,SW(2),o22,o23,o24,o25);
	
	conversor12: conversorModulo port map(o19,o20,o21,o22,BCD(8),BCD(7),BCD(6),BCD(5));
	conversor13: conversorModulo port map(o23,o24,o25,SW(1),BCD(4),BCD(3),BCD(2),BCD(1));
	
	conversor14: conversorModulo port map(e4,e0,e1,e2,BCD(12),BCD(11),BCD(10),BCD(9));
	
	BCD(0) <= SW(0);
end Hardware;