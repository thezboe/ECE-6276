----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Bryce Williams
-- 
-- Create Date: 11/07/2017 12:05:52 PM
-- Design Name: 
-- Module Name: tb_sobel - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test Bench for sobel.vhd
-- 
-- Dependencies: sobel.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_sobel is
end tb_sobel;

architecture Behavioral of tb_sobel is
    component sobel is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               d_in : in STD_LOGIC_VECTOR (7 downto 0);
               fval_in : in STD_LOGIC := '1';
               lval_in : in STD_LOGIC := '1';
               d_out : out STD_LOGIC_VECTOR (7 downto 0);
               fval_out : out STD_LOGIC;
               lval_out : out STD_LOGIC);
    end component sobel;

    constant T: time := 20 ns;

    signal clk_int : std_logic;
    signal d_in_int: std_logic_vector (7 downto 0) := "00000000";
    signal d_out_int: std_logic_vector (7 downto 0);
    signal cnt : natural := 0;

begin
    dut : sobel port map(clk => clk_int, rst => '0', d_in => d_in_int, d_out => d_out_int,
                         fval_in => open, lval_in => open, fval_out => open, lval_out => open);
    
    clkgen: 
    process is 
    begin
        clk_int <= '1';
        wait for T/2;
        clk_int <= '0';
        wait for T/2;
    end process; 

    clkcnt:
    process (clk_int) is
    begin
        if rising_edge(clk_int) then
         cnt <= cnt + 1;
        end if;
    end process;

    r_w_buff:
    process (clk_int) is
    begin
        if rising_edge(clk_int) then
            d_in_int <= std_logic_vector(unsigned(d_in_int) + 1);
        end if;
    end process;
end Behavioral;
