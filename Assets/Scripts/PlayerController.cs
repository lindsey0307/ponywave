using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour {

	public float moveSpeed;
	public float speedMultiplier;
	public float speedIncreaseMilestone;

	public float jumpForce;
	public float dashForce;
	public bool grounded;
	public LayerMask whatIsGround;
	public Transform groundCheck;
	public float groundCheckRadius;
	public float jumpTime;
	public GameManager theGameManager;


	private Rigidbody2D myRigidbody;
	//private Collider2D myCollider;
	private Animator myAnimator;
	private float jumpTimeCounter;
	public float speedMilestoneCount;
	private bool stoppedJumping;
	private bool canDoubleJump;
	private float moveSpeedStore;
	private float speedMilestoneCountStore;
	private float speedIncreaseMilestoneStore;

	public float foo;
	private PlatformGenerator platformGen;

	void Start () {
		myRigidbody = GetComponent<Rigidbody2D>();
		//myCollider = GetComponent<Collider2D>();
		myAnimator = GetComponent<Animator>();
		jumpTimeCounter = jumpTime;
		speedMilestoneCount = speedIncreaseMilestone;
		stoppedJumping = true;

		moveSpeedStore = moveSpeed;
		speedMilestoneCountStore = speedMilestoneCount;
		speedIncreaseMilestoneStore = speedIncreaseMilestone;

		foo = speedMilestoneCount;
		platformGen = GameObject.Find("PlatformGenerator").GetComponent<PlatformGenerator>();
	}
	

	void Update () {

		grounded = Physics2D.OverlapCircle(groundCheck.position, groundCheckRadius, whatIsGround);

		if (transform.position.x > speedMilestoneCount) {
			foo = speedMilestoneCount;
			speedMilestoneCount += speedIncreaseMilestone;
			speedIncreaseMilestone = speedIncreaseMilestone * speedMultiplier;
			moveSpeed = moveSpeed * speedMultiplier;
		}
		myRigidbody.velocity = new Vector2(moveSpeed, myRigidbody.velocity.y);

		if(Input.GetKeyDown(KeyCode.Space) || Input.GetMouseButtonDown(0)){
			if (grounded) {
				myRigidbody.velocity = new Vector2(myRigidbody.velocity.x, jumpForce);
				stoppedJumping = false;
			}

			// Body Slam Mechanic
			if (!grounded && canDoubleJump) {
				myRigidbody.velocity = new Vector2(myRigidbody.velocity.x, jumpForce);
				//myRigidbody.rotation = 270;
				jumpTimeCounter = jumpTime;
				stoppedJumping = false;
				canDoubleJump = false;
			}
		}

		if ((Input.GetKey(KeyCode.Space) || Input.GetMouseButton(0)) && !stoppedJumping) {
			if (jumpTimeCounter > 0) {
				myRigidbody.velocity = new Vector2(myRigidbody.velocity.x, jumpForce);
				jumpTimeCounter -= Time.deltaTime;
			}
		}
		if (Input.GetKeyUp(KeyCode.Space) || Input.GetMouseButtonUp(0)) {
			jumpTimeCounter = 0;
			stoppedJumping = true;
			myRigidbody.rotation = 0;

		}

		if (grounded) {
			jumpTimeCounter = jumpTime;
			canDoubleJump = true;

		}

		myAnimator.SetFloat("Speed", myRigidbody.velocity.x);
		myAnimator.SetBool("Grounded", grounded);
	}

	void OnCollisionEnter2D(Collision2D other){
		if (other.gameObject.tag == "killbox") {
			theGameManager.RestartGame();
			moveSpeed = moveSpeedStore;
			speedMilestoneCount = speedMilestoneCountStore;
			speedIncreaseMilestone = speedIncreaseMilestoneStore;

			foo = speedMilestoneCount;
			platformGen.distanceBetweenMax = platformGen.distanceBetweenMaxStore;
			platformGen.distanceBetweenMin = platformGen.distanceBetweenMinStore;
		}
	}
}
