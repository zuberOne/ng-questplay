use src::pyramid::searchChamber;
use core::box::BoxTrait;
use array::ArrayTrait;
use clone::Clone;
use option::OptionTrait;

use src::pyramid::{ Chamber, Pyramid };

// ╔════════════════════════════════════════════╗
// ║         PART #1: Into<Pyramid, Array>      ║
// ╚════════════════════════════════════════════╝

impl PyramidIntoArray<
    T, 
    impl TClone: Clone<T>, 
    impl TDrop: Drop<T>
> of Into<Pyramid<T>, Array<T>> {
    fn into(self: Pyramid<T>) -> Array<T> {
        // new array for piramid
        let mut pirArray = ArrayTrait::new();
        let mut beenThere = ArrayTrait::new();
        let mut root = self.top;
        let mut index = root;
        let mut visited = 0;
        let mut upper_index = 0;

        
        loop {

            // i was everywhere so lets finish
            if pirArray.len() == self.chambers.len() {

                break;
                
            }                
            // im here
             let _chamber = self.chambers.get(index).unwrap().unbox();
            // looking down
             match _chamber.lower_chambers {
                Option::Some(chambersTuple) => {
                    let (leftIndex, rightIndex) = *chambersTuple;

                   // println!("lower indexes {}, {}", leftIndex, rightIndex);

                    let leftChamber = self.chambers.get(leftIndex).unwrap().unbox();
                    // look into the basement
                    match leftChamber.lower_chambers {
                        // there is something lower
                        Option::Some => {

                            upper_index = index;
                
                            let mut beenThereSpan = beenThere.span();
                            visited = 0;

                            loop {
                                // array iteration
                                match beenThereSpan.pop_front() {
                                    Option::Some(v) => {
                                     //   println!("looping {}", v );
                                        upper_index = index;
                                        // benn left
                                        if leftIndex == *v {
                                           // println!("found lastroot left {}", v );              
                                             visited  = 1;                                      
                                            
                                        };
                                        // benn right
                                        if rightIndex == *v {
                                            
                                           // println!("found lastroot right {}", v );
                                             visited += 1;

                                        }
                                        // been top
                                        if index == *v {
                                            visited += 1;
                                        }                                        

                                    },
                                    // array ends
                                    Option::None(_) => {
                                       
                                        if visited == 1 {
                                            //println!("been left, appending up {}", index);
                                            
                                            pirArray.append(_chamber.item.clone());
                                            upper_index = index;
                                            index = rightIndex;

                                        }
                                        if visited == 2 {
                                            //println!("been left & right");
                                             // beenthere root
                                             beenThere.append(index);
                                            // back to beginning
                                            index = root;
                                        }
                                        if visited == 0 {
                                            //been nowhere

                                            upper_index = index;
                                            index = leftIndex;
                                        }

                                        if visited == 3 {
                                           
                                           break;
                                        }                                        
                                        break ;
                                    }
                                }
                                };                          
                        },
                        // there is nothing so lets map it 
                        Option::None => {
                          //  println!("found bottom");
                         //   println!("appending to beenthere {}", index );
                            beenThere.append(index); 

                           let rightChamber = self.chambers.get(rightIndex).unwrap().unbox();
                         //  println!("addid item from index {}",  leftIndex);
                         
                           pirArray.append(leftChamber.item.clone());
                        // println!("addid item from index {}",  index);
                           pirArray.append(_chamber.item.clone());
                        // println!("addid item  from index {}",  rightIndex);
                            pirArray.append(rightChamber.item.clone());
                            index = upper_index;

                        }
                    }

                },              
                Option::None => {
                        // if this was i newer version i would use if let Option::Some() ....
                }
             }

        };
        pirArray
    }
}

// ╔════════════════════════════════════════════╗
// ║          PART #2: Pyramid Search           ║
// ╚════════════════════════════════════════════╝

trait PyramidSearchTrait<T> {
    fn search(self: @Pyramid<T>, key: T) -> Option<Array<T>>;
}

impl PyramidSearchImpl<
    T, 
    impl TClone: Clone<T>, 
    impl TDrop: Drop<T>, 
    impl TPartialEq: PartialEq<T>
> of PyramidSearchTrait<T> {
    fn search(self: @Pyramid<T>, key: T) -> Option<Array<T>> {
        // IMPLEMENT THIS FUNCTION
        Option::None
    }
}