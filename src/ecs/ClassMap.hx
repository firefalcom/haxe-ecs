package ecs;

import haxe.ds.StringMap;
import haxe.Constraints;

class ClassMap<K:Class<Dynamic>, V> implements haxe.IMap<K, V>
{
    var valueMap:StringMap<V> = new StringMap<V>(); // class name to value
    var keyMap:StringMap<K> = new StringMap<K>(); // class name to class

    public inline function new():Void
    {
    }

    public inline function get(k:K):Null<V>
    {
        return valueMap.get(Type.getClassName(k));
    }

    public inline function set(k:K, v:V):Void
    {
        var name:String = Type.getClassName(k);
        keyMap.set(name, k);
        valueMap.set(name, v);
    }

    public inline function exists(k:K):Bool
    {
        return valueMap.exists(Type.getClassName(k));
    }

    public inline function remove(k:K):Bool
    {
        var name:String = Type.getClassName(k);
        keyMap.remove(name);
        return valueMap.remove(name);
    }

    public inline function keys():Iterator<K>
    {
        return keyMap.iterator();
    }

    public inline function iterator():Iterator<V>
    {
        return valueMap.iterator();
    }

    public inline function toString():String
    {
        return valueMap.toString();
    }

    public inline function clear():Void {
        valueMap.clear();
        keyMap.clear();
    }

    public inline function copy():haxe.IMap<K, V>
    {
        throw ":TODO:";
    }

    public inline function keyValueIterator():KeyValueIterator<K, V>
    {
        throw ":TODO:";
    }
}
