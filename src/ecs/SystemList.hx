package ecs;

import ecs.GenericListIterator;

/**
 * Used internally, this is an ordered list of Systems for use by the engine update loop.
 */
class SystemList {
    @:allow(ecs)
    var head:System;

    @:allow(ecs)
    var tail:System;

    public function new() {
    }

    public function add(system:System):Void {
        if(head == null) {
            head = tail = system;
            system.next = system.previous = null;
        } else {
            var node:System = tail;

            while(node != null) {
                if(node.priority <= system.priority) {
                    break;
                }

                node = node.previous;
            }

            if(node == tail) {
                tail.next = system;
                system.previous = tail;
                system.next = null;
                tail = system;
            } else if(node == null) {
                system.next = head;
                system.previous = null;
                head.previous = system;
                head = system;
            } else {
                system.next = node.next;
                system.previous = node;
                node.next.previous = system;
                node.next = system;
            }
        }
    }

    public function remove(system:System):Void {
        if(head == system) {
            head = head.next;
        }

        if(tail == system) {
            tail = tail.previous;
        }

        if(system.previous != null) {
            system.previous.next = system.next;
        }

        if(system.next != null) {
            system.next.previous = system.previous;
        }

        // N.B. Don't set system.next and system.previous to null because that will break the list iteration if system is the current system in the iteration.
    }

    public function removeAll():Void {
        while(head != null) {
            var system:System = head;
            head = head.next;
            system.previous = null;
            system.next = null;
        }

        tail = null;
    }

    public function get<TSystem:System>(type:Class<TSystem>):TSystem {
        var system:System = head;

        while(system != null) {
            if(Std.isOfType(system, type)) {
                return cast system;
            }

            system = system.next;
        }

        return null;
    }

    public function contains<TSystem:System>(type:Class<TSystem>):Bool {
        return get(type) != null;
    }

    public inline function iterator():GenericListIterator<System> {
        return new GenericListIterator(head);
    }
}
