import os
import xml.etree.ElementTree as ET

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def test_readme_content():
    readme_path = os.path.join(REPO_ROOT, "README.md")
    assert os.path.isfile(readme_path), "README.md must exist"
    with open(readme_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Verify key Johnnie88 projects are featured
    required_keywords = [
        "Johnnie88",
        "AZDOPS",
        "argocd-clickhouse",
        "AzOps-Accelerator",
        "azurechatgpt",
        "Alien Build Tech",
    ]
    for kw in required_keywords:
        assert kw in content, f"Missing required keyword in README.md: {kw}"

    # Verify no leftover placeholder author
    assert "lxlynx" not in content, "README.md should not contain lxlynx references"
    assert "Alexander Cardoza" not in content, "README.md should not contain Cardoza references"
    print("✓ test_readme_content passed")

def test_svg_assets():
    assets_dir = os.path.join(REPO_ROOT, "assets")
    for svg_name in ["header.svg", "now.svg"]:
        svg_path = os.path.join(assets_dir, svg_name)
        assert os.path.isfile(svg_path), f"Asset {svg_name} must exist"
        tree = ET.parse(svg_path)
        root = tree.getroot()
        assert root.tag.endswith("svg"), f"{svg_name} root element must be <svg>"
    print("✓ test_svg_assets passed")

def test_repo_integrity():
    for root, _, files in os.walk(REPO_ROOT):
        if ".git" in root:
            continue
        for file in files:
            if file == "smoke.py":
                continue
            if file.endswith((".md", ".svg", ".py")):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    data = f.read()
                assert "lxlynx" not in data, f"Found leftover lxlynx in {file}"
                assert "Alexander Cardoza" not in data, f"Found leftover Cardoza in {file}"
    print("✓ test_repo_integrity passed")

if __name__ == "__main__":
    test_readme_content()
    test_svg_assets()
    test_repo_integrity()
    print("All smoke tests passed successfully!")
