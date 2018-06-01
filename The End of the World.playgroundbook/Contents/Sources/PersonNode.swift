//
//  PersonNode.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import ARKit
import UIKit

public class PersonNode {
    public var node: SCNNode!
    public var model: Person
    private var lastAxis = SCNVector3Make(0, 0, 0)
    
    private var spawnCount = 0
    
    
    public init(model: Person, position: SCNVector3, cameraPosition: SCNVector3) {
        self.model = model
        self.node = createNode()
        self.node.position = position
        self.node.rotation = SCNVector4Make(0, 1, 0, 0)
        
        let deltaRotation = getXZRotation(towardsPosition: cameraPosition)
        if deltaRotation > 0 {
            node.rotation.w -= deltaRotation
        }else if deltaRotation < 0 {
            node.rotation.w -= deltaRotation
        }
    }
	
    private func getXZRotation(towardsPosition toPosition: SCNVector3) -> Float {
        
        // Creates the normalized XZ Distance vector
        var unitDistance = (toPosition - node.position).negate()
        unitDistance.y = 0
        unitDistance = unitDistance.normalized()
        
        // Creates the normalized XZ Direction vector for the alien (which way it is facing)
        var unitDirection = self.node.convertPosition(SCNVector3Make(0, 0, -1), to: nil) - self.node.position
        unitDirection.y = 0
        unitDirection = unitDirection.normalized()
        
        // Finds the angle between the two vectors and uses the direction of the cross product to decide it's sign
        let axis = unitDistance.cross(vector: unitDirection).normalized()
        let angle = acos(unitDistance.dot(vector: unitDirection))
        return angle * axis.y
    }
    
    private func createNode() -> SCNNode {
        // Set the general scale for the alien image. 
        // In the future we should really change the images
        let scaleFactor = model.image.size.width/0.2
        let width = model.image.size.width/scaleFactor
        let height = model.image.size.height/scaleFactor
        
        // Creates a Plane Geometry object to represent the front of the alien
        let geometryFront = SCNPlane(width: width, height: height)
        let materialFront = SCNMaterial()
        materialFront.diffuse.contents = model.image
        geometryFront.materials = [materialFront]
        
        // Creates a Plane Geometry object to represent the back of the alien
        let geometryBack = SCNPlane(width: width, height: height)
        let materialBack = SCNMaterial()
        materialBack.diffuse.contents = model.image
        geometryBack.materials = [materialBack]
        
        // Creates nodes for both and sets the backNode's position to be directly
        // behind the main node
        let mainNode = SCNNode(geometry: geometryFront)
        let backNode = SCNNode(geometry: geometryBack)
        backNode.position = SCNVector3Make(0, 0, 0)
        backNode.rotation = SCNVector4Make(0, 1, 0, Float.pi)
		
        mainNode.physicsBody?.isAffectedByGravity = false
        mainNode.addChildNode(backNode)
        return mainNode
    }
    
}
