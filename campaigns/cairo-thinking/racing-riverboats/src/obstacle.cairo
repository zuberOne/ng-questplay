#[derive(Drop,Clone)]
struct Obstacle {
    length: u32,
    width: u32,
    description: Array<felt252>
}