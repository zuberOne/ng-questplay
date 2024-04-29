use core::box::BoxTrait;
use core::option::OptionTrait;
use core::array::SpanTrait;
use core::clone::Clone;
use core::array::ArrayTrait;
use src::obstacle::Obstacle;

fn find_crocodiles(river: @Array<Obstacle>) -> Array<usize> {
    // IMPLEMENT THIS FUNCTION
    let mut crocodiles = ArrayTrait::new();
    let mut spanRiverOuter = river.span();
    let mut outerIndex = 0;

   // let mut isCrocodile = false;

        loop {      
           let dupa = crocodiles.len();
            
            match spanRiverOuter.pop_front() {
              
                Option::Some(v) => { 
                 let mut spanCrocodiles = crocodiles.span();
                 let mut hasBeenAdded = false;

                  loop { 
                    match spanCrocodiles.pop_front() {
                        Option::Some(z) => { 
                          if outerIndex == *z {
                            hasBeenAdded = true;
                            break;
                          }
                        },
                        Option::None(_) => {
                            break;
                        }
                    };    
                    };    //end loop  

                    
                if !hasBeenAdded {
                        let mut innerIndex = outerIndex + 1;
                        let mut spanRiverInner = spanRiverOuter;
                        
                    loop {

                        match spanRiverInner.pop_front() {
                            
                            Option::Some(x) => { 
                                if v.length == x.length &&
                                v.width == x.width &&
                                v.description == x.description {
                          
                                 crocodiles.append(innerIndex); 
                                }

                            },

                            Option::None(_) => {

                                    
                              break;
                            }
                      
                    }; // end inner match

                           innerIndex += 1;
                    }  ;
                      if crocodiles.len() > dupa {
                        crocodiles.append(outerIndex);
                      };   
                } 
                    outerIndex += 1;
                },

                Option::None(_) => {   
                    break; // outer match
                }
             };             

             }; // end loop


             crocodiles
         } // end   fn

