export default function SubmitButton({ loading }: { loading?: boolean }) {
  return (
    <button
      type="submit"
      className="btn btn-primary w-full col-span-2 my-4"
      disabled={loading}
    >
      {!loading && "Skicka in"}
      {loading && <div className="loading loading-dots loading-sm" />}
    </button>
  );
}
