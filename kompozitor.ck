// kompozitor.ck

// This script combines any utilities scripts from the "utils" folder with any scripts from the "performance" folder
// such that any Chuck script will have access to the public class/functions in any scripts previously added to the machine
// Performance scripts should be added as command-line arguments using the following syntax:
//
// chuck kompozitor.ck:[script name 1]:[script name 2..n]
//
// Only the name of the chuck script should be passed, kompozitor assumes the script to run resides in the "performance" folder
// If multiple arguments are passed, they will be added to the virtual machine and executed simultaneously.
// Therefore, it is recommended that the performance script(s) control sporking, but it may make sense to run a separate
// main performance script to control inputs, separating the concerns of scripted and live performance into threads at the top 

Machine.add("utils/time.ck");
Machine.add("utils/freqcalc.ck");             // Import the FreqCalc class module into the central namespace
Machine.add("utils/chord.ck");

if( me.args() > 0 ) // If arguments are passed from the command line 
{
   for ( int i; i < me.args(); i++)
   Machine.add("performance/" + me.arg(i));         // Run the script from the performance directory matching the argument 
}
else
{
   Machine.add("performance/tuneup.ck");         // Run the tuneup script  
}
