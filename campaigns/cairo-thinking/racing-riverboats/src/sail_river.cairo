use core::box::BoxTrait;
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
    let mut x = 0;

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
    while  x < sortedCrocs.len()  {

            let mut first = sortedCrocs.get(x).unwrap().unbox();
            let mut second = sortedCrocs.get(x + 1).unwrap().unbox();
            let mut third = sortedCrocs.get(x + 2).unwrap().unbox();

            if *first > index + 3 {
                numberOfJumps += 1;
                index + 3;
                
            }

            if *first + *second  == 1 && 3 != 2 {
                numberOfJumps += 1;
                index + 3;
                x += 2;
                
            }

            if *first + *second  == 2 {
                numberOfJumps += 1;
                index + 2;
                x += 1;
                
            }            

            if *first - index + *second - index + *third - index == 6 {
                println!("noroute " );
                noRoute = true;
                break;
            }

            if *first - index + *second - index == 5 {
                index += 1;
                numberOfJumps += 1;
                
                
            }

            if *first - index + *second - index  == 3 {
                index += 3;
                numberOfJumps += 1;
                x += 2;
                
            }

            if *first - index + *second - index  == 4 {
                index += 2;
                numberOfJumps += 1;
                x += 1;
                
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

