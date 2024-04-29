use core::clone::Clone;
use core::option::OptionTrait;
use core::array::SpanTrait;
use core::array::ArrayTrait;
use src::obstacle::Obstacle;
use src::find_crocodiles::find_crocodiles;

fn sail_river(obstacles: Array<Obstacle>) -> Option<usize> {

    
    // IMPLEMENT THIS FUNCTION
    let mut crocodiles = find_crocodiles(@obstacles);
    let mut anotherCrocodiles = crocodiles.span();
    //let mut sortedCrocs::ArrayTrait = array![];
    let mut sortedCrocs = ArrayTrait::<usize>::new();
    let mut index:usize = 0;
    let mut numberOfJumps:usize = 0;
    let mut y:usize = 0;
    let mut high = 0;
    let mut noRoute = false;

// sort
    

                ///// TO Jteż mogę wrzucić w funkcj
                /// 
                // catch if no crocodiles
    if crocodiles.len() == 0 {
        while index < obstacles.len() {
            index += 3;
            numberOfJumps += 1;
            println!(" number of jumps {}",numberOfJumps );

        };
        return Option::Some(numberOfJumps);
    }/// e


    y = *anotherCrocodiles.pop_front().unwrap();
    loop {
       
        match anotherCrocodiles.pop_front() {

            Option::Some(z)=> {
                
                    if *z > y  { y = *z } ;
            
            },
            Option::None(_) => {

                println!("lagerst index {}", y);
                high = y;
                break;

            },
        }

    };                

    anotherCrocodiles = crocodiles.span();
    // trzeba zrobić po indeksie
    loop {
        
       // if sortedCrocs.len() == crocodiles.len() {break;}
        //let mut sortedCrocs4Looking = sortedCrocs;
       // if !started {  y = *anotherCrocodiles.pop_front().unwrap(); started = true};
        
       
        match anotherCrocodiles.pop_front() {

            Option::Some(z)=> {
               
                    if *z < y  {
                            if !checkIfExistsInArray(ref sortedCrocs, *z) { 
                                y = *z;
                            }

                        } ;
           
            },
            Option::None(_) => {

                println!("lowest index this loop {}", y);
                sortedCrocs.append(y);
                println!("new len  {}, oryg len {}",sortedCrocs.len(), crocodiles.len() );
                if y == high {break;}
                y = high;
                anotherCrocodiles = crocodiles.span();
            },
        }

    };


    /// sail    - to to sie wywala
        loop {
            let mut jumped = false;
            match sortedCrocs.pop_front() {
                Option::Some(first) => {
                    if first == index { println!("no route"); noRoute = true; break; };
                    numberOfJumps += 1;
                    println!("croc pop {} at i am standing at index {}", first, index );
                    // take care of crocs out of jump range
                    if first > index + 3 {
                        println!("crocs out of range , jumping 3");

                        index += 3;
                        jumped = true
                    } else {

                    if first == index + 3 {

                        index += 2;
                        println!("jumping 2");
                        jumped = true;
                        
                
                    }                         
                        
                  if !jumped {
                    let mut second = sortedCrocs.pop_front().unwrap();
                    loop {
                        

                        println!("first {}, second {}", first, second );

                        if second > index + 3 {
                            println!("inner crocs out of range , jumping 3");

                            index += 3;         
                            break;                       
                        }

                        let mut calc = second - index + first - index;

                        println!("equals  {}", calc );


                        if calc == 5 {

                            index += 1;
                            println!("jumping 1");
                            break;
                        }

                        if calc == 3 {
                            
                            index += 3;
                            println!("jumping 2");
                            break;
                        }


                        if calc == 4 {
                            
                            index += 2;
                            println!("jumping 2");
                            break;
                        }                        
                        
                        break;
                                                     
                    };
                } // end if not jumped
                    }
                    
                },

                Option::None(_) => {
                    while index < obstacles.len() {
                        println!("no crocs left. jumping 3 {}", index);
                        println!("obst len {}", obstacles.len());
                        
                        index += 3;
                        numberOfJumps += 1;
                        println!(" number of jumps {}",numberOfJumps );
                    };
                    break;
                }
            }
        };

    if noRoute { return Option::<usize>::None; };
    println!("final number of jumps {}",numberOfJumps );
    Option::Some(numberOfJumps)
}


fn checkIfExistsInArray(ref checkArray: Array<usize>, val: usize) -> bool {
    let mut checkArraySpan = checkArray.span();
    let mut result = false;
    loop {
        match checkArraySpan.pop_front() {
            Option::Some(x) => {
                if val == *x { result = true; break;}                                    
            },
            Option::None => {                    
                    break;
                
            },
        }
    };
    result
  }

