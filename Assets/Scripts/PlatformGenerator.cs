using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlatformGenerator : MonoBehaviour {

	public GameObject thePlatform;
	public Transform generationPoint;
	public float distanceBetweenMin;
	public float distanceBetweenMinStore;
	public float distanceBetweenMax;
	public float distanceBetweenMaxStore;
	public ObjectPooler[] theObjectPools;
	//public GameObject[] thePlatforms;
	public Transform maxHeightPoint;
	public float maxHeightChange;
	public float distanceBetweenMultiplier;
	public PlayerController thePlayer;


	private float distanceBetween;
	private float platformWidth;
	private int platformSelector;
	private float[] platformWidths;
	private float minHeight;
	private float maxHeight;
	private float heightChange;


	void Start () {
		//platformWidth = thePlatform.GetComponent<BoxCollider2D>().size.x;
		platformWidths = new float[theObjectPools.Length];
		for (int i = 0; i < theObjectPools.Length; i++) {
			platformWidths[i] = theObjectPools[i].pooledObject.GetComponent<BoxCollider2D>().size.x;
		}
		minHeight = transform.position.y;
		maxHeight = maxHeightPoint.position.y;
		thePlayer = FindObjectOfType<PlayerController>();

		distanceBetweenMinStore = distanceBetweenMin;
		distanceBetweenMaxStore = distanceBetweenMax;

		
	}
	
	void Update () {
		if (transform.position.x < generationPoint.position.x) {
			
			if (thePlayer.transform.position.x > thePlayer.foo) {
				distanceBetweenMin += distanceBetweenMultiplier;
				distanceBetweenMax += distanceBetweenMultiplier;
			}

			distanceBetween = Random.Range(distanceBetweenMin, distanceBetweenMax);
			platformSelector = Random.Range(0, theObjectPools.Length);

			heightChange = transform.position.y + Random.Range(maxHeightChange, -maxHeightChange);

			if (heightChange > maxHeight) {
				heightChange = maxHeight;
			} else if (heightChange < minHeight) {
				heightChange = minHeight;
			}
			transform.position = new Vector3(transform.position.x + (platformWidths[platformSelector]/2) + distanceBetween, heightChange, transform.position.z);

			//Instantiate(/*thePlatform*/ thePlatforms[platformSelector], transform.position, transform.rotation);

			GameObject newPlatform = theObjectPools[platformSelector].GetPooledObject();
			newPlatform.transform.position = transform.position;
			newPlatform.transform.rotation = transform.rotation;
			newPlatform.SetActive(true);

			transform.position = new Vector3(transform.position.x + (platformWidths[platformSelector]/2), transform.position.y, transform.position.z);

		}
	}
}
