library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity mod_m_counter_prog is
    generic(M : natural -- Modulo
    );
    port(clk_i       : in std_logic;
        reset_i      : in std_logic;
        run_i        : in std_logic; --  Activador
        count_o      : out std_logic_vector (M-1 downto 0);
        max_o        : out std_logic
    );
end entity;

architecture rtl of mod_m_counter_prog is
    signal r_reg  : unsigned(M-1 downto 0):= (others => '0');
    signal r_next : unsigned(M-1 downto 0):= (others => '0');
    signal max    : unsigned(3 downto 0):= "1001";
begin
    NXT_STATE_PROC: process(clk_i)
    begin
        if rising_edge(clk_i) then
            if (reset_i = '1') then
                r_reg <= (others => '0');
            elsif run_i = '1' then
                r_reg <= r_next;
            end if;
        end if;
    end process;
    r_next <= (others => '0') when r_reg = max else r_reg + 1;
    count_o <= std_logic_vector(r_reg);
    max_o <= '1' when ((r_reg = max) and (run_i = '1')) else '0';
end architecture;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;


entity stopwatch is
    generic(M : natural := 4);
        port(clk_i : in std_logic;
            clr_i: in std_logic;
            en_i: in std_logic;
            count_o : out std_logic_vector (M-1 downto 0);
            max_o : out std_logic
            );
end entity;

architecture structural of stopwatch is
    signal count_0: std_logic_vector(M-1 downto 0):= (others => '0');
    signal count_1 : std_logic_vector(M-1 downto 0):= (others => '0');
    signal count_2 : std_logic_vector(M-1 downto 0):= (others => '0');
    signal count2 : std_logic;
    signal count3 : std_logic;
    signal none_o: std_logic;

begin
    CONT1: entity work.mod_m_counter_prog
    generic map(M => M)
    port map (clk_i => clk_i,
            reset_i => clr_i,
            run_i => en_i,
            count_o => count_0,
            max_o => count2
            );

    CONT2: entity work.mod_m_counter_prog
    generic map(M => M)
    port map (clk_i => clk_i,
            reset_i => clr_i,
            run_i => count2,
            count_o=> count_1,
            max_o => count3 
            );

    CONT3: entity work.mod_m_counter_prog
    generic map(M => M)
    port map (clk_i => clk_i,
            reset_i => clr_i,
            run_i => count3, 
            count_o=> count_2,
            max_o => none_o
            );
end architecture;

