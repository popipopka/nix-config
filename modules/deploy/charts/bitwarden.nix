{ ... }:
{
  "apiVersion" = "helm.cattle.io/v1";
  "kind" = "HelmChart";
  "metadata" = {
    "name" = "bitwarden-sm-operator";
    "namespace" = "kube-system";
  };
  "spec" = {
    "repo" = "https://charts.bitwarden.com/";
    "chart" = "sm-operator";
    "targetNamespace" = "sm-operator-system";
    "createNamespace" = true;
  };
}
