struct Chamber<T> {
    item: T,
    lower_chambers: Option<(usize, usize)>
}
struct Pyramid<T> {
    top: usize,
    chambers: Array<Chamber<T>>
}

impl ChamberDrop<T, impl TDrop: Drop<T>> of Drop<Chamber<T>>;
impl PyramidDrop<T, impl TDrop: Drop<T> > of Drop<Pyramid<T>>;


pub trait searchChamber<T> {
    fn getItem(self: @Pyramid<T>, index: usize) -> T;
    fn getMap(self: @Pyramid<T>, index: usize) -> Option<(usize, usize)>;
}

pub impl searchChamberImpl<
        T,     
        impl TClone: Clone<T>, 
        impl TDrop: Drop<T>
        > of searchChamber<T> {
        fn getItem(self: @Pyramid<T>, index: usize ) -> T {
        self.chambers.get(index).unwrap().unbox().item.clone()
        }
        fn getMap(self:  @Pyramid<T>, index: usize) -> Option<(usize, usize)> {
        *self.chambers.get(index).unwrap().unbox().lower_chambers   
        }
}
