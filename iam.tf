resource "aws_iam_role" "test_eks"{
    name="test_eks"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy"  {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role=aws_iam_role.test_eks.name
  
}
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role=aws_iam_role.test_eks.name
  
}
resource "aws_eks_cluster" "eks_cluster" {
    name="eks_cluster"
    role_arn = aws_iam_role.test_eks.arn
    vpc_config {
      subnet_ids=[aws_subnet.dev_subnet_private_1a.id, aws_subnet.dev_subnet_private_1b.id]
    }
    depends_on = [

      aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
      aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]
    
  
}
resource "aws_iam_role" "eks_nodes" {
    name="eks_nodes"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}  
resource "aws_eks_node_group" "node_group" {
    cluster_name=aws_eks_cluster.eks_cluster.name
    node_group_name="node_group"
    node_role_arn=aws_iam_role.eks_nodes.arn
    subnet_ids=[aws_subnet.dev_subnet_private_1a.id, aws_subnet.dev_subnet_private_1b.id]
    scaling_config{
        desired_size=1
        max_size=1
        min_size=1
        

    }
    depends_on=[
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
        ]
  
}

