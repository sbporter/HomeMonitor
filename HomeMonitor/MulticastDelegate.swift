//
//  MulticastDelegate.swift
//  HomeMonitor
//
// This class was taken from http://www.gregread.com/2016/02/23/multicast-delegates-in-swift/
//
//

import Foundation

class MulticastDelegate <T> {
    private var weakDelegates = [WeakWrapper]()
    
    func addDelegate(delegate: T) {
        // If delegate is a class, add it to our weak reference array
        weakDelegates.append(WeakWrapper(value: delegate as AnyObject))
    }
    
    func removeDelegate(delegate: T) {
        // If delegate is an object, let's loop through weakDelegates to find it.
        for (index, delegateInArray) in weakDelegates.enumerated().reversed() {
            // If we have a match, remove the delegate from our array
            if delegateInArray.value === (delegate as AnyObject) {
                weakDelegates.remove(at: index)
            }
        }
    }
    
    func invoke(invocation: (T) -> ()) {
        // Enumerating in reverse order prevents a race condition from happening when removing elements.
        for (index, delegate) in weakDelegates.enumerated().reversed() {
            // Since these are weak references, "value" may be nil at some point when ARC is 0 for the object.
            if let delegate = delegate.value {
                invocation(delegate as! T)
            }
                // Else, ARC killed it, get rid of the element from our array
            else {
                weakDelegates.remove(at: index)
            }
        }
    }
}

func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.addDelegate(delegate: right)
}

func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.removeDelegate(delegate: right)
}

private class WeakWrapper {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
}
