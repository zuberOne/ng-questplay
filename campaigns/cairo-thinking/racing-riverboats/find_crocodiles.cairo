use core::option::OptionTrait;
use core::array::SpanTrait;
use core::clone::Clone;
use core::array::ArrayTrait;
use src::obstacle::Obstacle;

fn find_crocodiles(river: @Array<Obstacle>) -> Array<usize> {
    // IMPLEMENT THIS FUNCTION
    let mut crocodiles:Array<usize> = ArrayTrait::new();

    let mut spanRiverOuter = river.span();
    let mut outerIndex = 0;
    

    /// dodaj indexy jak jest duplikat, jeśli ten indeks jest w array to skip


        loop {      
            let mut isCrocodile = false;
           // let mut spanRiverInner = river.clone();
            let mut spanCrocodiles = crocodiles.span();
            let mut hasBeenAdded = false;
          //  let mut innerIndex = 0;

           // array iteration
            //println!("outer loop, looking for duplicate of outer index {}", outerIndex);0
            match spanRiverOuter.pop_front() {
                Option::Some(v) => { 
                    
                    loop { 
                 //   println!("check if index has been already added {}", outerIndex);
                    match spanCrocodiles.pop_front() {
                        Option::Some(z) => { 
                          if outerIndex == *z {
                            hasBeenAdded = true;
                          //  println!("already added at  {} from river", z);
                          }

                        },
                        // array ends
                        Option::None(_) => {
                            
                            break;
                        }
                    };    
                    };   //end loop  
                    
                if !hasBeenAdded {
                        let mut innerIndex = outerIndex + 1;
                        let mut spanRiverInner = spanRiverOuter;

                    loop {

      

                        //if innerIndex > outerIndex {
                     //   println!("inner loop, looking for crocodiles at inner  index : {}", innerIndex);
                        match spanRiverInner.pop_front() {
                            
                            Option::Some(x) => { 
                                if v.length == x.length &&
                                v.width == x.width &&
                                v.description == x.description {

                        //        println!("found crocodiles at {}, adding to array", innerIndex);
                                if !isCrocodile { isCrocodile = true; }
                                crocodiles.append(innerIndex); 

                                }

                            },
                            // array ends
                            Option::None(_) => {
                                if isCrocodile {

                                    crocodiles.append(outerIndex);
                                  //  println!("add original crocodiles at {}", outerIndex);
                                    
                                    };
                             break;
                            }
                      
                    }; 
                       // } else {
                           // spanRiverInner.pop_front().unwrap();
                         //   }
                      innerIndex += 1;
                    }     
                } //if has been added   
                    outerIndex += 1;
                },
                // array ends - outer match end
                Option::None(_) => {
                   // println!("end at {}", outerIndex);
                   
                    break;
                }
             };             


             }; // end loop
            //println!("croc len: {}", crocodiles.len());

             crocodiles
         } // end   fn
