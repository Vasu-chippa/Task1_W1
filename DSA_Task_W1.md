

**1 .Longest Subarray with Sum K**





class Solution {

&#x20;   public int longestSubarray(int\[] arr, int k) {

&#x20;       // code here

&#x20;       HashMap<Integer,Integer> map = new HashMap<>();

&#x20;       int sum=0,max=0;

&#x20;       for(int i=0;i<arr.length;i++){

&#x20;           sum+=arr\[i];

&#x20;           if(sum==k) max =i+1;

&#x20;           if(map.containsKey(sum-k)){

&#x20;               int len = i-map.get(sum-k);

&#x20;               max =Math.max(max,len);

&#x20;           }

&#x20;           if(!map.containsKey(sum)){

&#x20;               map.put(sum,i);

&#x20;           }

&#x20;       }return max;

&#x20;   }

}

**\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_**

















**\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_**





4.Kth Largest Element in a Stream



class Solution {

&#x20;   static ArrayList<Integer> kthLargest(int\[] arr, int k) {

&#x20;       // code here

&#x20;       List<Integer> al = new ArrayList<>();

&#x20;       ArrayList<Integer> res = new ArrayList<>();

&#x20;       for(int num : arr){

&#x20;           al.add(num);

&#x20;           Collections.sort(al);

&#x20;           if(al.size()<k) res.add(-1);

&#x20;           else res.add(al.get(al.size()-k));

&#x20;       }return res;

&#x20;   }

}



**\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_**



**5 Detect and Remove Cycle in Linked List**



class Solution {

&#x20;   public static void removeLoop(Node head) {

&#x20;       // code here

&#x20;       HashSet<Node> st=new HashSet<>();

&#x20;       Node prev=null;

&#x20;       while(head!=null \&\& head.next!=null ) {

&#x20;           if(!st.contains(head)) {

&#x20;                  st.add(head);

&#x20;                  prev =head;

&#x20;                   head=head.next;

&#x20;           }

&#x20;           else {

&#x20;               prev.next=null;

&#x20;               break;

&#x20;           }

&#x20;       }

&#x20;   }

}











**\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_**



**10.Range Maximum Query with Updates**





**import java.util.\*;**

**class MAxQuery {**

&#x20;   **public static int tree\[];**

&#x20;   **public static void build(int index,int st,int ed,int arr\[]) {**

&#x20;       **if(st==ed){**

&#x20;           **tree\[index] = arr\[st];**

&#x20;           **return;**

&#x20;       **}**

&#x20;       **int mid = (st+ed)/2;**

&#x20;       **build((2\*index)+1,st,mid,arr);**

&#x20;       **build((2\*index)+2,mid+1,ed,arr);**

&#x20;       **tree\[index] = Math.max(tree\[2\*index+1] , tree\[2\*index+2]);**

&#x20;   **}**

&#x20;   **public static void update(int index,int st,int ed,int arr\[],int x,int val) {**

&#x20;       **if(st==ed) {**

&#x20;           **arr\[x] = val;**

&#x20;           **tree\[index] = val;**

&#x20;           **return;**

&#x20;       **}**

&#x20;       **int mid=(st+ed)/2;**

&#x20;       **if(x<=mid)**

&#x20;           **update(2\*index+1,st,mid,arr,x,val);**

&#x20;       **else**

&#x20;           **update(2\*index+2,mid+1,ed,arr,x,val);**

&#x20;       **tree\[index] = Math.max(tree\[2\*index+1] , tree\[2\*index+2]);**

&#x20;   **}**

&#x20;   **public static int query(int index,int st,int ed,int i,int j) {**

&#x20;       **if(i > ed || j < st)**

&#x20;           **return Integer.MIN\_VALUE;**

&#x20;       **if(i<=st \&\& ed<=j)**

&#x20;           **return tree\[index];**

&#x20;       **int mid = (st+ed)/2;**

&#x20;       **return Math.max( query(2\*index+1,st,mid,i,j) , query(2\*index+2,mid+1,ed,i,j));**

&#x20;   **}**

&#x09;**public static void main(String\[] args)  {**

&#x09;	**Scanner sc = new Scanner(System.in);**

&#x09;	**int n = sc.nextInt();**

&#x09;	**tree = new int\[4\*n];**

&#x09;	**int arr\[] = new int\[n];**



&#x09;	**for(int i=0;i<n;i++) arr\[i] = sc.nextInt();**

&#x09;	**build(0,0,n-1,arr);**

&#x09;	**int Q = sc.nextInt();**

&#x09;	**for(int i=0;i<Q;i++) {**

&#x09;	    **int type = sc.nextInt();**

&#x09;	    **if(type==1)  {**

&#x09;	        **int index = sc.nextInt();**

&#x09;	        **int new\_val = sc.nextInt();**

&#x09;	        **update(0,0,n-1,arr,index,new\_val);**

&#x09;	    **}**

&#x09;	    **else {**

&#x09;	        **int st = sc.nextInt();**

&#x09;	        **int ed = sc.nextInt();**

&#x09;	        **System.out.println(query(0,0,n-1,st,ed));**

&#x09;	    **}**

&#x09;	**}**

&#x09;**}**

**}**

