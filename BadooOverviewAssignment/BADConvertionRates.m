//
//  BADConvertionRates.m
//  
//
//  Created by Valeriy Van on 19.12.15.
//
//

#import "BADConvertionRates.h"

// Helper struct
typedef struct Weight { double weight; BOOL visited; } Weight;

// Helper functions forward declaration
BOOL allVisited(Weight *array, NSUInteger count);
NSUInteger minidx(Weight *array, NSUInteger count);
void printWeights(Weight *array, NSUInteger count);

@interface BADConvertionRates ()
@property NSArray *rates;
@end


@implementation BADConvertionRates

-(instancetype)initWithRates:(NSArray*)r {
    if ((self = [super init])) {
        self.rates = [r copy];
    }
    return self;
}

- (NSDictionary*)rateFor:(NSString*)f {
    return [[self.rates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.from == %@", f]] firstObject];
}

-(double)rateFrom:(NSString*)from to:(NSString*)to {
    if ([from isEqualToString:to]) {
        return 1;
    }
    //NSArray *filteredRates = [self.rates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.from == %@ && self.to == %@", from, to]];
    //if (filteredRates.count > 0) {
    //    return [[filteredRates firstObject][@"rate"] doubleValue];
    //}

    if (!self.rates) {
        return 0;
    }
    
    NSArray *fromVertices = [self.rates valueForKeyPath:@"@distinctUnionOfObjects.from"];
    NSArray *toVertices = [self.rates valueForKeyPath:@"@distinctUnionOfObjects.to"];
    NSArray *vertices = [@[fromVertices, toVertices] valueForKeyPath:@"@distinctUnionOfArrays.self"];
    
    // Set all weights to DBL_MAX
    NSUInteger verticesCount = vertices.count;
    Weight verticesWeights[verticesCount];
    for (NSUInteger i = 0; i<verticesCount; i++) {
        verticesWeights[i].weight = DBL_MAX;
        verticesWeights[i].visited = NO;
    }

    // Zero weight of initial vertex
    NSString *w = [[vertices filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == %@", from]] firstObject];
    NSUInteger widx = [vertices indexOfObject:w];
    verticesWeights[widx].weight = 0;
    //printWeights(verticesWeights, verticesCount);

    for ( ; !allVisited(verticesWeights, verticesCount); ) { // indefinite loop if graph is not interconected
        NSInteger indexOfVertexWithMinWeight = minidx(verticesWeights, verticesCount);
        verticesWeights[indexOfVertexWithMinWeight].visited = YES;

        NSArray *edges = [self.rates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.from == %@", vertices[indexOfVertexWithMinWeight]]];
        for (NSUInteger nextEngeIndex = 0; nextEngeIndex < edges.count; nextEngeIndex++) {
            NSDictionary *nextEdge = edges[nextEngeIndex];
            NSString *toVertex = [[vertices filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == %@", nextEdge[@"to"]]] firstObject];
            NSUInteger toVertexIndex = [vertices indexOfObject:toVertex];
            double weight = verticesWeights[indexOfVertexWithMinWeight].weight == 0 ? [nextEdge[@"rate"] doubleValue] : verticesWeights[indexOfVertexWithMinWeight].weight * [nextEdge[@"rate"] doubleValue];
            if (weight < verticesWeights[toVertexIndex].weight) {
                verticesWeights[toVertexIndex].weight = weight;
            }
        }
        
        //printWeights(verticesWeights, verticesCount);
    }
    
    //printWeights(verticesWeights, verticesCount);

    NSString *toVertex = [[vertices filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == %@", to]] firstObject];
    NSUInteger toIndex = [vertices indexOfObject:toVertex];
    
    return verticesWeights[toIndex].weight;
}

@end

BOOL allVisited(Weight *array, NSUInteger count) {
    for (NSUInteger i = 0; i < count; i++) {
        if (!array[i].visited) {
            return NO;
        }
    }
    return YES;
}
NSUInteger minidx(Weight *array, NSUInteger count) {
    assert(count > 1);
    
    // Let's the first not visited be current min
    NSUInteger idx = 0;
    for ( ;array[idx].visited; idx++);
    
    // Look throu
    for (NSUInteger i = 1; i < count; i++) {
        if (!array[i].visited && array[i].weight < array[idx].weight) {
            idx = i;
        }
    }
    
    return idx;
}

void printWeights(Weight *array, NSUInteger count) {
    for (NSUInteger i = 0; i < count; i++) {
        NSString *weight = [NSString stringWithFormat:@"%@", array[i].weight!=DBL_MAX ? [NSString stringWithFormat:@"%.2lf", array[i].weight] :@"inf"];
        NSLog(@"weight=%@, visited=%d", weight, array[i].visited?1:0);
    }
}

