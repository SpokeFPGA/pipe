#include "Vpipe_test.h"
#include <verilated.h>

#include <iostream>

int main(int argc, char** argv, char** env) {

    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);

    Vpipe_test* top = new Vpipe_test{contextp};
    top->clock = 0;
    top->in = 0;

    for (int i = 0; i < 100; i++ ) { 
        std::cout << i << std::endl;
        top->eval(); 
        top->clock = 1;
        top->eval(); 
        top->clock = 0;
    }

    delete top;
    delete contextp;
    
    return 0;
}
