resource "aws_eks_cluster" "main" {
  name     = "kubernetes-platform-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id,
      aws_subnet.private_c.id
    ]
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "main"

  node_role_arn = aws_iam_role.eks_nodes_role.arn

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
    aws_subnet.private_c.id
  ]

  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 3
    min_size     = 2
    max_size     = 6
  }
}