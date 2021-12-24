var a = 1;

func loopTest(){
    while(a < 20){
    
        print("Hello World");

        a++;
    }

    for(var a = 0; a < 3; a++){
        print(a);
    }

    for(;;){
        print("Infinite loop");
    }
}