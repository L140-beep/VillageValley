class_name Pit
extends Node2D

func getWater(bucket: Bucket):
	bucket.set_volume(bucket.max_volume)
