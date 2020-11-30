--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : Full_Adder_tb.vhw
-- /___/   /\     Timestamp : Fri Feb 14 15:11:51 2014
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: Full_Adder_tb
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY Full_Adder_tb IS
END Full_Adder_tb;

ARCHITECTURE testbench_arch OF Full_Adder_tb IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT Full_Adder
        PORT (
            a : In std_logic_vector (3 DownTo 0);
            b : In std_logic_vector (3 DownTo 0);
            s : Out std_logic_vector (4 DownTo 0);
            cin : In std_logic
        );
    END COMPONENT;

    SIGNAL a : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL b : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL s : std_logic_vector (4 DownTo 0) := "00000";
    SIGNAL cin : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : Full_Adder
        PORT MAP (
            a => a,
            b => b,
            s => s,
            cin => cin
        );

        PROCESS
            PROCEDURE CHECK_s(
                next_s : std_logic_vector (4 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (s /= next_s) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns s="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, s);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_s);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  400ns
                WAIT FOR 400 ns;
                b <= "1010";
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 100 ns;
                a <= "1111";
                -- -------------------------------------
                -- -------------  Current Time:  1000ns
                WAIT FOR 500 ns;
                cin <= '0';

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

