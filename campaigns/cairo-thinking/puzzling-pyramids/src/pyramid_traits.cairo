use core::traits::TryInto;
use core::traits::Into;
use core::array::SpanTrait;
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
        // IMPLEMENT THIS FUNCTIO
        // piramid span
        
        let mut pirSpan = self.chambers.span();

        let pirLen = self.chambers.len();

        let mut reversedMap : Array<T> = array![];

        let mut finalMap : Option<Array> = Option::None;

        let mut almostFinalMap: Array<T> = array![];

        let mut mapExists = false ;

        let mut noKey = true ;

        let mut index = 0;

        loop {
              
            
            // array iteration
            match pirSpan.pop_front() {
      
                Option::Some(v) => {
                    // find the key
                    if v.item == @key {
                        // original len - len of popped array - 1 cause array starts at 0 duh
                        index = pirLen - pirSpan.len() - 1;
                        println!("{}", index);
                        // save the key to array
                        reversedMap.append(v.item.clone());
                        // found key so no break
                        noKey = false;
                    }
                },
                // array ends
                Option::None(_) => {
                    break;
                }
             };     
        };
        // reload the piramid
        let mut pirSpan = self.chambers.span();

        loop {      
            // if nokey skip
            if noKey { break; }
           // array iteration
            match pirSpan.pop_front() {
                Option::Some(v) => { 
                    // check lower chambers
                    match v.lower_chambers {
                        Option::Some(chambersTuple) => {
                           let (left,right) = *chambersTuple;
                           
                           if left == index || right == index {
                                // save the key
                                
                                reversedMap.append(v.item.clone());
                                // set index to look for
                                index = pirLen - pirSpan.len() - 1; 
                                println!("{}", index);
                                // reload the piramid
                                pirSpan = self.chambers.span();
                                // if got to top end
                                if index == *self.top {
                                     mapExists = true;
                                      println!("exit loop");
                                       break;
                                 }   
                                  
                           }

                        },
                        Option::None => {
                            // just basement
                        }
                    
                    }; // end inner match

                },
                // array ends
                Option::None(_) => {
                    // no route to top
                    break;

                    
 
                }
             };             


         }; // end loop
            
        if mapExists {

            loop {
              
            // array iteration
                match reversedMap.pop_front() {
      
                    Option::Some(v) => {
                        almostFinalMap.append(v.clone());

                       
                },
                // array ends
                    Option::None(_) => {
                    break;
                }
             };  

            
            
        };
            let finallen = almostFinalMap.len();
            println!("{}", finallen);
            finalMap = Option::Some(almostFinalMap);
        }

        finalMap
            
    }
} 
