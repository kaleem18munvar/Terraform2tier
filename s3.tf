/*
resource "aws_s3_bucket" "snapbucket" {
  bucket = "snap-tf-bucket" 

  tags = {
    Name        = "My tf bucket"
  }
}
resource "aws_s3_bucket_acl" "s3bucketacl" {
  bucket = aws_s3_bucket.snapbucket.id
  acl    = "private"
}

resource "aws_s3_bucket_object" "snapobject"{
    bucket = aws_s3_bucket.snapbucket.id
    key = aws_db_snapshot.testdbsnap.db_snapshot_identifier
    source = aws_db_snapshot.testdbsnap.db_instance_identifier
}
*/
